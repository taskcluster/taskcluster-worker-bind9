DNS Server for TaskCluster Workers
==================================

This is a simple DNS server setup that hosts a DNAME record mapping all EC2
machines to a subdomain under `ec2.taskcluster-worker.net`. This means that any
EC2 machine will have a domain under `ec2.taskcluster-worker.net`, and will be
able to server HTTP content from under that domain. However, only notes that
we operate will be able to serve HTTPS content.

Implementation Details
----------------------
All EC2 nodes have a hostname on the form:

    ec2-<ip>.<region>.compute.amazonaws.com

Using a DNAME record, we map everything under `ec2.taskcluster-worker.net` to
`compute.amazonaws.com`. Which effectively makes
`ec2-<ip>.<region>.ec2.taskcluster-worker.net` a CNAME for
`ec2-<ip>.<region>.compute.amazonaws.com`.


Security Remarks
----------------
This means that anybody who launches an EC2 node will have an associated
hostname: `ec2-<ip>.<region>.ec2.taskcluster-worker.net`.
Clearly we can't trust anything served over HTTP from a sub-domain of
`ec2.taskcluster-worker.net`. We can treat any such sub-domain with the same
trust we give any sub-domain of `compute.amazonaws.com`. Hence, we can reasonbly
trust it, if we know that the node is owned by us. However, we can also trust if
content is accessed over HTTPS.

This is a compromise worth making because the DNS setup is so simple and
utilizes already existing cache for the EC2 hostnames issued by AWS.
There is no per worker setup, no DNS propagation delay, and no clean-up as
would be the case if we used dynamic DNS to attach custom sub-domains.

All in all this is a pretty elegant solution.

