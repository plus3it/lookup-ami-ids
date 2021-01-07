"""Lookup AMI ID."""

import collections
import json
import logging
import os

import cfnresponse
import exceptions

import boto3

DEFAULT_LOG_LEVEL = logging.DEBUG
LOG_LEVELS = collections.defaultdict(
    lambda: DEFAULT_LOG_LEVEL,
    {
        "critical": logging.CRITICAL,
        "error": logging.ERROR,
        "warning": logging.WARNING,
        "info": logging.INFO,
        "debug": logging.DEBUG,
    },
)

# Lambda initializes a root logger that needs to be removed in order to set a
# different logging config
root = logging.getLogger()
if root.handlers:
    for _handler in root.handlers:
        root.removeHandler(_handler)

LOG_FILE_NAME = ""
if not os.environ.get("AWS_EXECUTION_ENV"):
    LOG_FILE_NAME = "ami-lookup.log"

logging.basicConfig(
    filename=LOG_FILE_NAME,
    format="%(asctime)s.%(msecs)03dZ [%(name)s][%(levelname)-5s]: %(message)s",
    datefmt="%Y-%m-%dT%H:%M:%S",
    level=LOG_LEVELS[os.environ.get("LOG_LEVEL", "").lower()],
)
log = logging.getLogger(__name__)

ec2 = boto3.client("ec2")


def build_search_body(event):
    """Extract owners and filters from event."""
    owners = json.loads(event["Owners"])
    filters = json.loads(event["Filters"])

    return {"Owners": owners, "Filters": filters}


def get_ami_id(event):
    """Gather EC2 AMI ID."""
    response = ec2.describe_images(**build_search_body(event))
    amis = sorted(response["Images"], key=lambda x: x["CreationDate"], reverse=True)
    ami_id = amis[0]["ImageId"]

    log.info("found ami: %s", ami_id)
    return ami_id


def handler(event, context):
    """Return AMI ID from event."""
    log.debug("Received event: %s", event)

    response_status = cfnresponse.SUCCESS
    response_value = event["ResourceProperties"]
    response_data = {}
    response_data["Data"] = response_value

    if event["RequestType"] != "Delete":
        try:
            response_data["Id"] = get_ami_id(response_value)
            if not response_data["Id"]:
                raise exceptions.NoResultsException(
                    "Ami Id search returned no results!"
                )
        except Exception as exc:
            cfnresponse.send(event, context, cfnresponse.FAILED, {"Error": f"{exc}"})
            log.error("Error encountered while searching for ami: %s", exc)
            raise

    cfnresponse.send(event, context, response_status, response_data)
