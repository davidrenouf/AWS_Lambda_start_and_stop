import boto3
from instance_management import InstanceManagement
from rds_management import RdsManagement
from autoscaling_management import AutoscalingManagement

def lambda_handler(event, context):
    filter_admin_instances = [{'Name': 'tag:env', 'Values': ['admin']}]
    admin_instances = InstanceManagement(boto3.client('ec2'), filter_admin_instances)
    admin_instances.stop()

    filter_generic_gitlab = [{'Name': 'tag:eks:nodegroup-name', 'Values': ['common-k8s-gitlab-eks-generic-node-group']}]
    generic_gitlab = AutoscalingManagement(boto3.client('autoscaling'), filter_generic_gitlab)
    generic_gitlab.display()
    generic_gitlab.stop()

    filter_admin_db_cluster = [{'Name': 'db-cluster-id', 'Values': ['admin-devfactory-aurora-cluster']}]
    admin_db_cluster = RdsManagement(boto3.client('rds'), filter_admin_db_cluster)
    admin_db_cluster.display()
    admin_db_cluster.stop()
