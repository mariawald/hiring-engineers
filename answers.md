#Tech Writer exercise
##Setup the environment

1. Spinup a fresh linux VM via Vagrant.


![Installing VirtualBox](./screenshots/1_vb_installed.jpg "Installing VirtualBox")

![Setup Vagrant 1](./screenshots/2_setting_up_vagrantpm.jpg "Setting up Vagrant part 1")

![Setup Vagrant 2](./screenshots/3.1_vagrant_up.jpg "Setting up Vagrant part 2")

![Setup Vagrant 2](./screenshots/3.2_vagrant_up.jpg "Setting up Vagrant part 2")

2. Sign up for Datadog

![Signing up](./screenshots/4_signing_up.jpg "Setting up Vagrant part 2")

3. Get the Agent reporting metrics from your machine.

![Curl check](./screenshots/5.1_curl_not_installed.jpg "Curl check")

![Curl installation](./screenshots/5.2_curl_installing.jpg "Curl installation")

![Agent integration](./screenshots/6_install_datadog_agent.jpg "Agent integration")

![Agent integration](./screenshots/7_agent_installed.jpg "Agent installed")

![Agent integration](./screenshots/9_agent_reporting_dashboard.jpg "Agent installed")

##Collecting metrics

1. Add tags in the Agent config file and show us a screenshot of your host and its tags on the Host Map page in Datadog.

![Host tags](./screenshots/10.1_host_tags.jpg "Host tags")

![Yaml tags config](./screenshots/10.2_yaml_tags.jpg "Yaml tags config")

2. Install a database on your machine (MongoDB, MySQL, or PostgreSQL) and then install the respective Datadog integration for that database.

![MySQL](./screenshots/11_install_mysql.jpg "Installing MySQL")

![MySQL](./screenshots/12_mysql_installed.jpg "MySQL installed")

![MySQL](./screenshots/13_mysql_user_grant_privileges.jpg "Installing MySQL")

![MySQL](./screenshots/14_mysql_user_for_agent.jpg "mysql user")


![MySQL integration](./screenshots/15_slave_status.jpg "Installing MySQL integration")

3. Create a custom Agent check that submits a metric named my_metric with a random value between 0 and 1000.


```python
try:
    # first, try to import the base class from old versions of the Agent...
    from checks import AgentCheck
except ImportError:
    # ...if the above failed, the check is running in Agent version 6 or later
    from datadog_checks.checks import AgentCheck

	# content of the special variable __version__ will be shown in the Agent status page
__version__ = "1.0.0"

import random

class MyMetricCheck(AgentCheck):
    def check(self, instance):
        self.gauge('my_metric', random.randint(0,1000), tags=[])
```

4. Change your check's collection interval so that it only submits the metric once every 45 seconds.

```yml
init_config:

instances:
  - min_collection_interval: 45

```

5. *Bonus Question* Can you change the collection interval without modifying the Python check file you created?

##Visualizing data

1. Utilize the Datadog API to create a Timeboard that contains:

* Your custom metric scoped over your host.

* Any metric from the Integration on your Database with the anomaly function applied.

```json
{
  "title": "my_metric_dashboard",
  "widgets": [
    {
      "definition":{
        "type": "timeseries",
        "requests":[{"q": "avg:my_metric{host:maria-ubuntu}"}]
      }
    },
    {
      "definition":{
        "type": "timeseries",
        "requests":[{"q": "anomalies(avg:mysql.innodb.mem_total{host:maria-ubuntu}, 'basic', 2)"}]
      }
    }
  ],
  "layout_type": "ordered",
  "description": "The dashboard I have to do for the exercise"
}

```
![Timeseries_anomaly](./screenshots/timeseries_anomaly.jpg "Timeseries and anomaly")

2. Once this is created, access the Dashboard from your Dashboard List in the UI:


* Set the Timeboard's timeframe to the past 5 minutes.

Note: We spoked over email and you changed the time to 15 min.

![Host tags](./screenshots/change_in_custom_metric_period.jpg "Change to 15 mins")


* Take a snapshot of this graph and use the @ notation to send it to yourself.

![Host tags](./screenshots/send_notation.jpg "Host and tags")

* Bonus Question: What is the Anomaly graph displaying?