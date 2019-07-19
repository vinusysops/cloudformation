Script to start an instance:

    import boto3

    region = ‘ap-south-1’

    instances = [‘i]

    def lambda_handler(event, context):
    ec2 = boto3.client(‘ec2’, region_name=region)
    ec2.start_instances(InstanceIds=instances)
    print ‘started your instances: ‘ + str(instances)

Script to stop an instance:

    import boto3

    region = ‘ap-south-1’

    instances = [‘i-XXXXXXXXXXXXXXXXX’,’i-XXXXXXXXXXXXXXXXX’]

    def lambda_handler(event, context):
    ec2 = boto3.client(‘ec2’, region_name=region)
    ec2.stop_instances(InstanceIds=instances)
    print ‘stopped your instances: ‘ + str(instances)
