package container

unauthorized_base_image[result] {
  some i
  data.resources.PackageVersion[i].spec.container_metadata.base_image.name
  base_image_name := data.resources.PackageVersion[i].spec.container_metadata.base_image.name

  # Ignore if base_image_name is empty or not set
  base_image_name != ""

  # Check if the base_image_name is not in the allowed list
  not allowed_base_images[base_image_name]

  result = {
    "Endor": {
      "PackageVersion": data.resources.PackageVersion[i].uuid,
    },
    "BaseImage": base_image_name,
    "Message": sprintf("Base image '%s' is not allowed.", [base_image_name])
  }
}

# Define the list of allowed base images
allowed_base_images := {"python:3.10-alpine", "alpine:latest", "ubuntu:20.04"}

# Do not add this and the below to the rego statement - settings for Endor UI
# As of 3rd Sept 2024 this requires a label in the Dockerfile:
# LABEL org.opencontainers.image.base.name='python:3.9-alpine'

# Query statement:
# data.container.unauthorized_base_image

# Resource kinds:
# PackageVersion

# Summary:
# Endor Labs detected that your container is not on the list of containers approved by your organization.

# Finding Categories:
# Container

# Finding Name:
# Unapproved Base Container Image

# Name:
# Approved container images

# Description:
# Verifies if containers are using approved images
