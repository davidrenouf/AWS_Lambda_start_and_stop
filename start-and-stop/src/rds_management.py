import logging
from botocore.exceptions import ClientError

logger = logging.getLogger(__name__)

class RdsManagement:

    def __init__(self, client, filter):
        self.client = client
        self.filter = filter

    def display(self):
        try:
            return self.client.describe_db_clusters( Filters = self.filter)
        except ClientError as err:
            logger.error(
                "Couldn't display your rds. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise

    def start(self):
        try:
            for db_cluster in self.filter[0]['Values']:
                self.client.start_db_cluster(DBClusterIdentifier = db_cluster)
        except ClientError as err:
            logger.error(
                "Couldn't display your rds. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise

    def stop(self):
        try:
            for db_cluster in self.filter[0]['Values']:
                print("Stoping db(s) %s", db_cluster)
                self.client.stop_db_cluster(DBClusterIdentifier = db_cluster)
        except ClientError as err:
            logger.error(
                "Couldn't display your rds. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise

    def verify(self):
        try:
            print("Checking db(s) statuses")
            for instance in self.display()['DBClusters'][0]['DBClusterMembers']:
               self.client.get_waiter('db_instance_available').wait(DBInstanceIdentifier=instance['DBInstanceIdentifier'])
        except ClientError as err:
            logger.error(
                    "Couldn't display your rds. Here's why: %s: %s",
                    err.response['Error']['Code'], err.response['Error']['Message'])
            raise
