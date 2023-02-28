import boto3
from instance_management import InstanceManagement
from rds_management import RdsManagement
from autoscaling_management import AutoscalingManagement


def lambda_handler(event, context):
    
    filter_instance_to_stop = [
        {'Name': 'tag:Name', 'Values': ['<InstanceName>']}]
    instances_to_stop = InstanceManagement(
        boto3.client('ec2'), filter_instance_to_stop)
    instances_to_stop.stop()

    filter_asg_to_stop = [{'Name': 'tag:Name', 'Values': ['<AsgName>']}]
    asg_to_stop = AutoscalingManagement(
        boto3.client('autoscaling'), filter_asg_to_stop)
    asg_to_stop.stop()

    filter_db_cluster_to_stop = [
        {'Name': 'db-cluster-id', 'Values': ['<DbClusterId>']}]
    db_cluster_to_stop = RdsManagement(
        boto3.client('rds'), filter_db_cluster_to_stop)
    db_cluster_to_stop.stop()
