export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "xemotransfer3d99df233d99df23": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string",
            "CreatedSNSRole": "string"
        }
    },
    "api": {
        "xemotransfer": {
            "GraphQLAPIKeyOutput": "string",
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    },
    "analytics": {
        "xemotransfer": {
            "Region": "string",
            "Id": "string",
            "appName": "string"
        }
    },
    "function": {
        "TriggerKycVerification": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    }
}