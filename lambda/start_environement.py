import boto3
from instance_management import InstanceManagement
from rds_management import RdsManagement
from autoscaling_management import AutoscalingManagement


def lambda_handler(event, context):

    filter_instance_to_start = [
        {'Name': 'tag:Name', 'Values': ['<InstanceName>']}]
    instances_to_start = InstanceManagement(
        boto3.client('ec2'), filter_instance_to_start)
    instances_to_start.start()

    filter_asg_to_start = [{'Name': 'tag:Name', 'Values': ['<AsgName>']}]
    asg_to_start = AutoscalingManagement(
        boto3.client('autoscaling'), filter_asg_to_start)
    asg_to_start.start()

    filter_db_cluster_to_start = [
        {'Name': 'db-cluster-id', 'Values': ['<DbClusterId>']}]
    db_cluster_to_start = RdsManagement(
        boto3.client('rds'), filter_db_cluster_to_start)
    db_cluster_to_start.start()
