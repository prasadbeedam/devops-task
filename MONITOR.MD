📊 Monitoring & Logging with Amazon CloudWatch (EKS)
1. Configure Logging

EKS by default does not send pod logs to CloudWatch. To enable it, deploy the AWS for Fluent Bit add-on (recommended by AWS):

aws eks create-addon \
  --cluster-name my-eks-cluster \
  --addon-name aws-for-fluent-bit \
  --region us-east-1


This will:

Run Fluent Bit as a DaemonSet on each node.

Collect logs from /var/log/containers/*.log.

Push them into CloudWatch Logs.

Each pod’s logs will appear under a log group:

/aws/containerinsights/<cluster-name>/application

2. Configure Metrics (Container Insights)

To collect CPU, memory, disk, and network metrics from nodes and pods, enable CloudWatch Container Insights.

Using Helm:

helm repo add amazon-cloudwatch https://amazoncloudwatch.github.io/helm-charts
helm repo update

# CloudWatch Agent for metrics
helm upgrade --install cloudwatch-agent \
  amazon-cloudwatch/cloudwatch-agent \
  --namespace amazon-cloudwatch --create-namespace

# Fluent Bit for logs (if not using add-on)
helm upgrade --install fluent-bit \
  amazon-cloudwatch/fluent-bit \
  --namespace amazon-cloudwatch


This setup will:

Send performance metrics to CloudWatch Metrics.

Send application logs to CloudWatch Logs.

Automatically enable Container Insights dashboards.

3. Viewing Logs in CloudWatch

Go to AWS Console → CloudWatch → Logs → Log groups.

Look for:

/aws/containerinsights/<cluster-name>/application


Select the log group → choose a stream (one per pod/container).

View real-time logs from your logo-server app.

4. Viewing Metrics in CloudWatch

Go to CloudWatch → Metrics.

Under ContainerInsights, you’ll find:

Node metrics (CPU, Memory, Disk, Network).

Pod metrics (per-pod CPU & Memory usage).

Service metrics (request/connection counts).

Create custom CloudWatch Dashboards for visualization.

Optionally, set Alarms (e.g., CPU > 80%).

5. Example: Checking Logs for logo-server
# Tail logs directly from CloudWatch
aws logs tail /aws/containerinsights/my-eks-cluster/application --follow


✅ With this setup, you’ll have end-to-end monitoring:

Logs (application + system) → CloudWatch Logs.

Metrics (CPU, Memory, Disk, Network) → CloudWatch Metrics.

Dashboards & Alerts → CloudWatch Dashboards + Alarms.