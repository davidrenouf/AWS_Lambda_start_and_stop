import os
import boto3
from instance_management import InstanceManagement
from rds_management import RdsManagement
from autoscaling_management import AutoscalingManagement


def lambda_handler(event, context):

    InstanceName = os.environ['InstanceName'].split(",")
    AsgName = os.environ['AsgName'].split(",")
    DbClusterId = os.environ['DbClusterId'].split(",")

    ### Manage Instances ###
    if InstanceName != ['null']:
        filter_instance_to_start = [
            {'Name': 'tag:Name', 'Values': InstanceName}]
        instances_to_start = InstanceManagement(
            boto3.client('ec2'), filter_instance_to_start)
        instances_to_start.start()

    ### Manage ASG ###
    if AsgName != ['null']:
        for asgname in AsgName:
            filter_asg_to_start = [{'Name': 'tag:Name', 'Values': [asgname]}]
            asg_to_start = AutoscalingManagement(
                boto3.client('autoscaling'), filter_asg_to_start)
            asg_to_start.start()

    ### Manage RDS ###
    if DbClusterId != ['null']:
        for dbclusterid in DbClusterId:
            filter_db_cluster_to_start = [
                {'Name': 'db-cluster-id', 'Values': [dbclusterid]}]
            db_cluster_to_start = RdsManagement(
                boto3.client('rds'), filter_db_cluster_to_start)
            db_cluster_to_start.start()
