# Terraform_Assignment

Q) Create a Terraform module that provisions multiple EC2 instances with the following requirements:
Single Variable: Use a single variable to configure 5 EC2 instances with different instance types, volume types, volume size and key pairs.
Each instance should have:
An instance type (e.g., t2.micro, m5.large, etc.)
A volume type (e.g., gp2, io1, etc.)
A volume size (e.g., 8, 10, 20, etc.)
A key pair for SSH access (e.g., key1, key2, etc.)

A) 
Step 1: Define a Map Variable
Use a single map(object) variable to configure all instances.
Includes: instance_type, volume_type, volume_size, key_name, and optional iops.

Step 2: Fetch Ubuntu 22.04 AMI via SSM
Use the aws_ssm_parameter data source to dynamically get the latest Ubuntu 22.04 AMI ID.
Avoids hardcoding AMI IDs.

STEP 3: Create EC2 Instances Using for_each
Iterate over the map to create one EC2 instance per entry.
Attach root block device with volume_type, volume_size, and conditionally iops for io1/io2.

STEP 4: Conditionally Set IOPS
Use a ternary operator to add iops only if the volume type is io1 or io2.

STEP 5: Pass Input in Root Module
Provide configurations for all 5 instances in one neat map input.

NOTE: In the above steps we are adding the Keys with naming key1, key2, key3, key4 and key 5 to the environment so they can directly pull it during creation.

-------------------------------------------------------------------------------------------------------------------------------

Q) Step 1 - create basic groups and users in the account 000000000000
- 2 groups:
- group1 - should contain users with cli access only
  Users:
    - engine
    - ci
- group2 - must contain full users
  Users:
   - John Doe
   - Aboubacar Maina
- each group must have appropriate policies

A) 
Step 1: Define Groups and Users
Group1: CLI-only access
Users: engine, ci

Group2: Full user access
Users: John Doe, Aboubacar Maina → Must be renamed to valid IAM usernames (e.g., John_Doe, Aboubacar_Maina)

Step 2: Use a Reusable Terraform Module
Create a module iam_group_user to:
Create IAM group
Attach policies to group
Create users
Assign users to group

3. Attach Appropriate Policies
Group1: Use limited or CLI-only policy (e.g., PowerUserAccess, or a custom CLI-only policy)

Group2: Use full access (e.g., AdministratorAccess)

NOTE: Here i am sure on how to provide the only CLI access and i took PowerUserAccess as reference from Internet.

--------------------------------------------------------------------------------------------------------------------------------------------------

Q) create roles in the account 000000000000
  - roleA - administrative role with a policy that allows access to all AWS services except
IAM
  - roleB - a service role with a policy that allows you to assume the roleC role in the AWS
account 1111111111

A)
STEP 1: Create roleA
Purpose: Administrative role with broad permissions.
Permissions:
Full access to all AWS services.
Explicitly denied access to IAM (iam:*).
Attached Policy: Custom inline policy that allows * but denies iam:*.

STEP 2. Create roleB
Purpose: A service role (e.g., for EC2) that can assume a role (roleC) in another account (111111111111).
Permissions:
Allows sts:AssumeRole on the specific role roleC in the external account.
Assume Role Policy: Trusted by ec2.amazonaws.com (can be adjusted for other services).

---------------------------------------------------------------------------------------------------------------------------------------------------

Q) create a role in the 1111111111 account and allow assume from another account
- roleC is a service role that allows full access to the s3 bucket aws-test-bucket
  this role can be called by roleB from the 000000000000 account

A)
STEP 1: Configure AWS Provider for Account 1111111111
Use an alias (account1111) so you can specify which account to use for resources.

STEP 2:Create IAM Role (roleC) in Account 1111111111
Add a trust policy allowing roleB from account 000000000000 to assume it.

STEP 3: Create IAM Policy for S3 Access
Grants full access (s3:*) to the specific S3 bucket aws-test-bucket.

STEP 4: Attach the Policy to roleC
This gives roleC the permissions defined in the S3 access policy.

STEP 5: Explicitly specify the provider for each resource
Use provider = aws.account1111 to ensure resources are created in the correct account.

NOTE: I have used reference ID's for testing purpose.


