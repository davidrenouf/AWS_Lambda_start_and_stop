import logging
from botocore.exceptions import ClientError

logger = logging.getLogger(__name__)

class InstanceManagement:

    def __init__(self, client, filter):
        self.client = client
        self.filter = filter
        self.instance_ids = []

    def display(self):
        try:
            for reservation in self.client.describe_instances(Filters=self.filter)['Reservations']:
                for instance in reservation['Instances']:
                    self.instance_ids.append(instance['InstanceId'])
            print("Considering instance(s) %s", self.instance_ids)
            return self.instance_ids
        except ClientError as err:
            logger.error(
                "Couldn't find your instance(s) id's. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise

    def start(self):
        try:
            print("Starting instance(s) %s", self.instance_ids)
            event = self.client.start_instances(InstanceIds=self.instance_ids)
            print("Instance(s) %s started properly: %s", self.instance_ids, event)
        except ClientError as err:
            logger.error(
                "Instance(s) %s failed to start: %s: %s", self.instance_ids,
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise
        
    def stop(self):
        try:
            print("Stoping instance(s) %s", self.instance_ids)
            event = self.client.stop_instances(InstanceIds=self.instance_ids)
            print("Instance(s) %s stoped properly: %s", self.instance_ids, event)
        except ClientError as err:
            logger.error(
                "Instance(s) %s failed to stop: %s: %s", self.instance_ids,
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise

    def verify(self):
        try:
            print("Checking instance(s) statuses")
            return self.client.get_waiter('instance_running').wait(InstanceIds=self.instance_ids)
        except ClientError as err:
            logger.error(
                "Instance(s) %s failed to start: %s: %s", self.instance_ids,
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise
