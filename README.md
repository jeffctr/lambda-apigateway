# Deploying Lambad Function, API Gateway with Terraform

This is a very basic tutorial deploying your **lambda function** and firing it with **API Gateway**. The main Idea of this tutorial is to teach you how to to trigger your function through an API. <br/>
Perhaps you are wondering why use **API Gateway** to call my function if I can use task to do it. However, If you want to create a [Restful-API](https://restfulapi.net/) you will need to find a way how to trigger your function or even for a basic task that you want to run for your personal propose you can do it fast and easy. 


The good news is that in this tutorial we are going to use **Terraform** and this tool will help us a lot with AWS. I hate so much to use the AWS console because I need to create everything very manually and debugging it can be more difficult, but when you run Terraform it gives you details and information on what is going to deploy or what is happening.  


I will implement logs for the function so you can debug very easy.  

##File Structure
```buildoutcfg

├── api-spec
│   ├── build.sh
│   ├── components
│   │   ├── index.yml
│   │   ├── responses
│   │   │   └── index.yml
│   │   └── schemas
│   │       └── index.yml
│   ├── config
│   │   ├── apiGateway
│   │   │   └── proxy.yml
│   │   └── methods
│   │       └── options.yml
│   ├── index.yml
│   ├── info
│   │   └── index.yml
│   ├── paths
│   │   ├── hello
│   │   │   └── index.yml
│   │   └── index.yml
│   └── tags
│       └── index.yml
├── lambda
│   └── hello
│       ├── classes
│       │   ├── app.py
│       │   ├── hello.py
│       │   └── __init__.py
│       └── main.py
├── README.md
└── terraform
    ├── dev
    │   └── main.tf
    ├── terraform-module
    │   ├── apigateway.tf
    │   ├── iam.tf
    │   ├── lambda.tf
    │   └── variables.tf
    └── version.sh
```

##Terraform Module
The **Terraform** contains all the configuration that will take place in **AWS** once you deploy the project. However, I don't want to talk that much in this tutorial about Terraform because it has a really good documentation in its official website, but if you need this configuration to create your own project check the terraform-module that will help you to get your head around how to create different services and deploy them into **AWS**.


##Lambda
The lambda function is just a code logic that will receive the event and checks for the require values to run any execution. This code in written in python but you can deploy your own code in any language supported by **AWS**.
The main attributes coming in the object `event` are the `requestContext` that will give you details of the path that the API is targeting the request. The other important attribute is the `pathParameters` that will give the data coming in the method `GET`.  


These information is enough to determined which action to execute and return the response to the API. 

I am thinking to move this project a little bit further implementing a **Step Machine**. I think that this service will do a better job determing which lambda function to run, because you can run one lambda for each of your endponts. 

##API SPEC
The api-spec is just the generall configuration from Swagger check out the documentation. 
