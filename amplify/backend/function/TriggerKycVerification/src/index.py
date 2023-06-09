import json
import os
import boto3
from gql import gql
from gql.client import Client
from gql.transport.requests import RequestsHTTPTransport
from requests_aws4auth import AWS4Auth
import requests


def handler(event, context):
    #print(context)
    try:
        # iterate over each record
        for record in event['Records']:
            if record['eventName'] == 'INSERT':
                handle_insert(record)
            print('-----------------------------')
    except Exception as e:
        print(f'handler failed due to {e}')
    return "TESTING "

def handle_insert(record):
    
    print('Handling INSERT')
    # Get the new user data
    newImage = record['dynamodb']['NewImage']
    user_id = newImage['id']['S']
    email = newImage['email']['S']
    user_status = update_user_state_code(user_id=user_id)
    print("USER STATUS ", user_status)
    try:
        if user_status != "CONFIRMED":
            print('Sending Email confirmation')
            email_response = send_email_confirmation(email=email, user_id=user_id)
            #print(email_response)
        else:
            print('User is already CONFIRMED')
    except Exception as e:
        print("FAILED TO SEND EMAIL CONFIRMATION ", e)

    # Add user snapshot to async-operation
    #res_new_user = requests.post('localhost:8000/v1/async-operation/', data=user_data)
    #TODO handle django add or update record in mysql
def send_email_confirmation(email=None, user_id=None):
    secrets = get_secrets()
    username = secrets[1]
    password = secrets[2]
    data = {
        "user_id": user_id,
        "email": email
    }
    headers = {
        'Content-Type': 'application/json',
        'User-Agent': 'request',
    }
    response = requests.post("https://xemotransfer.dev/v1/send-email", headers=headers, data=json.dumps(data), auth=(username, password))
    #print(response)
def make_client(graphql_endpoint=None):
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
    }
    # Initiate a BOTO3 session
    session = boto3.session.Session(region_name="us-west-1")
    # Get credentials
    credentials = session.get_credentials().get_frozen_credentials()
    auth = AWS4Auth(
        credentials.access_key,
        credentials.secret_key,
        session.region_name,
        'appsync',
        session_token=credentials.token,
    )
    # Create a GraphQL client
    transport = RequestsHTTPTransport(url=graphql_endpoint,
                                      headers=headers,
                                      auth=auth)
    client = Client(transport=transport,
                    fetch_schema_from_transport=True)
    return client
def get_secrets():
    # Initiate a BOTO3 session
    session = boto3.session.Session(region_name="us-west-1")
    # Get credentials
    credentials = session.get_credentials().get_frozen_credentials()
    client = session.client(
        region_name=session.region_name,
        service_name='ssm'

    )
    response = client.get_parameters(
        Names=['/amplify/d35u2txb6woblr/test/AMPLIFY_TriggerKycVerification_GRAPHQL_ENDPOINT', '/amplify/d35u2txb6woblr/test/AMPLIFY_TriggerKycVerification_USERNAME',
        '/amplify/d35u2txb6woblr/test/AMPLIFY_TriggerKycVerification_password'],
        WithDecryption=True
    )
    graphql_endpoint = response['Parameters'][0]['Value']
    user_name = response['Parameters'][1]['Value']
    password = response['Parameters'][2]['Value']
    return [graphql_endpoint, user_name, password]

def update_user_state_code(user_id=None):
        secrets = get_secrets()
        user_status = ""
        graphql_endpoint = secrets[0]
        username = secrets[1]
        password = secrets[2]
        client = make_client(graphql_endpoint=graphql_endpoint)
        if user_id:
            params = {
                "id": str(user_id)
            }
            query = """
                    query MyQuery($input: ID!) {
                        getUser(id: $input) {
                            profileID origin_country_iso phone_number email user_status
                        }
                    }
                    """
            response_user = client.execute(gql(query), variable_values=json.dumps({'input': params['id']}))
            user_status = response_user.get('getUser', None).get('user_status', None)
            print(user_status)
            #print(f"RESPONSE USER {response_user}")
            origin_country = response_user.get('getUser', None).get('origin_country_iso', None)
            #print('response user', response_user)
            if response_user:
                profile_id = response_user.get('getUser', None).get('profileID')
                phone_number = response_user.get('getUser', None).get('phone_number')
                email = response_user.get('getUser', None).get('email')
                if profile_id:
                    params = {
                        "id": str(profile_id)
                    }
                    query = """
                            query GetProfile($input: ID!) {
                                getProfile(id: $input) {
                                    addressID gender country first_name last_name birth_dateID
                                }
                            }
                            """
                    response_profile = client.execute(gql(query), variable_values=json.dumps({'input': params['id']}))
                    #print('response profile', response_profile)
                    if response_profile:
                        address_id = response_profile.get("getProfile", None).get("addressID", None)
                        #print(address_id)
                        birth_date_id = response_profile.get("getProfile", None).get("birth_dateID", None)
                        #print(birth_date_id)
                        gender = response_profile.get('getProfile', None).get('gender', None)
                        #print(gender)
                        first_name = response_profile.get('getProfile', None).get('first_name', None)
                        #print(first_name)
                        last_name = response_profile.get('getProfile', None).get('last_name', None)
                        #print(last_name)
                        if address_id:
                            params = {
                                'id': str(address_id)
                            }
                            query = """
                                query GetAddress($input: ID!) {
                                    getAddress(id: $input) {
                                        postal_code state address_line_1 city
                                    }
                                }
                            """
                            response_address = client.execute(gql(query), variable_values=json.dumps({'input': params['id']}))
                            #print("response get address", response_address)
                            postal_code = response_address.get('getAddress', None).get('postal_code')
                            address_line_1 = response_address.get('getAddress', None).get('address_line_1')
                            city = response_address.get('getAddress', None).get('city')
                            state = response_address.get('getAddress', None).get('state')
                            params = {
                                'id': str(birth_date_id)
                            }
                            query = """
                                query GetBirthDate($input: ID!) {
                                    getBirthDate(id: $input) {
                                        date_of_birth
                                    }
                                }
                            """
                            response_birth = client.execute(gql(query), variable_values=json.dumps({'input': params['id']}))
                            #print("response get birth", response_address)
                            birth_date = response_birth.get('getBirthDate', None).get('date_of_birth')
                            data = {"user_snapshot":{
                                "city": city,
                                "uuid": user_id,
                                "email": email,
                                "state": state,
                                "gender": gender,
                                "country": origin_country,
                                "zip_code": postal_code,
                                "address_1": address_line_1,
                                "last_name": last_name,
                                "birth_date": birth_date,
                                "first_name": first_name,
                                "state_code": "12345",
                                "phone_number": phone_number
                            }}
                            headers = {
                                'Content-Type': 'application/json',
                                'User-Agent': 'request',
                            }
                            response = requests.post("https://xemotransfer.dev/v1/kyc-verify/", headers=headers, data=json.dumps(data), auth=(username, password))
                            #print(response)
                            return user_status
                        else:
                            print("ADDRESSID IS NONE!")
                            return user_status
                    else:
                        print("RESPONSE PROFILE IS NONE!")
                        return user_status
                else:
                    print("PROFILEID IS NONE!")
                    return user_status
            else:
                print("RESPONSE USER EMPTY")
                return user_status
        else:
            print('MUTATE UPDATE STATE CODE, USER IS NONE !')
            return user_status
