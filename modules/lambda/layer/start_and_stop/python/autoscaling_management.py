import logging
from botocore.exceptions import ClientError

logger = logging.getLogger(__name__)

class AutoscalingManagement:

    def __init__(self, client, filter):
        self.client = client
        self.filter = filter
        self.name = ''
        self.max_capacity = 0 
        self.min_capacity = 0

    def display(self):
        try:
            self.name = self.client.describe_auto_scaling_groups(Filters=self.filter)['AutoScalingGroups'][0]['AutoScalingGroupName']
            print("Considering autoscaling group %s", self.name)
        except ClientError as err:
            logger.error(
                "Couldn't display your asg. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise

    def get_size_tags(self):
        try:
            for tags in self.client.describe_auto_scaling_groups(Filters=self.filter)['AutoScalingGroups'][0]['Tags']:
                if tags['Key'] == 'autoscaling/min-capacity':
                    self.min_capacity = int(tags['Value'])
                if tags['Key'] == 'autoscaling/max-capacity':
                    self.max_capacity = int(tags['Value'])
            print("Max: %s, Min: %s", self.max_capacity, self.min_capacity)    
        except ClientError as err:
            logger.error(
                "Couldn't display your asg. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise
        
    def start(self):
        try:
            self.display()
            self.get_size_tags()
            print("Updating: %s Max: %s, Min: %s",self.name, self.max_capacity, self.min_capacity)
            self.client.update_auto_scaling_group(
                AutoScalingGroupName = self.name,
                MinSize = self.min_capacity,
                MaxSize = self.max_capacity)
            print("%s updated", self.name)
        except ClientError as err:
            logger.error(
                "Couldn't display your asg. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise
     
    def stop(self):
        try:
            self.display()
            self.get_size_tags()
            print("Updating: %s Max: 0, Min: 0",self.name, self.max_capacity, self.min_capacity)
            self.client.update_auto_scaling_group(
                AutoScalingGroupName = self.name,
                MinSize = 0,
                MaxSize = 0)
            print("%s updated", self.name)
        except ClientError as err:
            logger.error(
                "Couldn't display your asg. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise
