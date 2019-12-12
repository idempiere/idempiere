# Contributing to iDempiere

First off, thanks for taking the time to contribute! +1

We need volunteer developers to help this project come to fruition.

If you haven't already, come find us in [Mattermost](https://mattermost.idempiere.org/). We want you working on things you're excited about.

The following is a set of guidelines for contributing to iDempiere. These are mostly guidelines, not rules. 
Use your best judgment, and feel free to propose changes to this document in a pull request.

Before starting, make sure that you read our [code of conduct](CODE_OF_CONDUCT.md).This project and everyone participating in 
it is governed by the iDempiere's Code of Conduct. By participating, you are expected to uphold this code. 
Please report unacceptable behavior.

Here are some important resources:

  * [Test sites](https://www.idempiere.org/test-sites) lets you try iDempiere without installing it,
  * Bugs, feature requests and improvements? Use the [ticketing system for iDempiere](https://idempiere.atlassian.net/secure/Dashboard.jspa) - our JIRA system (for support please use our [forums](https://www.idempiere.org/forums))
  * Mattermost: [Support channel](https://mattermost.idempiere.org/idempiere/channels/support). We're usually there during business hours.
  
## How Can I Contribute?

### **Did you find a bug?**
* **Do not open up a JIRA ticket if the bug is a security vulnerability in iDempiere**, 
and instead refer to our [security policy](https://wiki.idempiere.org/en/How_to_report_a_vulnerability) page.
* **Ensure the bug was not already reported** by searching on JIRA under [Issues](https://idempiere.atlassian.net/issues/).
**Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.
* If you're unable to find an open issue addressing the problem, open a new one. Be sure to include a 
**title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** 
demonstrating the expected behavior that is not occurring, it is a good idea if you can reproduce the bug in one of the 
[test servers](https://www.idempiere.org/test-sites) before you create a ticket.

#### Before Submitting A Bug Report

* **Check if you can reproduce the problem in the latest version of iDempiere. 
* **Check the [FAQs on the forum](https://www.idempiere.org/forums)** for a list of common questions and problems.

#### How Do I Submit A (Good) Bug Report?

Bugs are tracked as [JIRA issues](https://idempiere.atlassian.net/issues/).

Explain the problem and include additional details to help maintainers reproduce the problem:

* **Use a clear and descriptive title** for the issue to identify the problem.
* **Describe the exact steps which reproduce the problem** in as many details as possible. 
* **Provide specific examples to demonstrate the steps**. If possible reproduce the problem with Garden data.
* **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
* **Explain which behavior you expected to see instead and why.**
* **Include screenshots and videos** - if possible, which show you following the described steps and clearly demonstrate the problem. 
* **If you're reporting that iDempiere crashed**, include a crash report with a stack trace from the log files. 
* **If the problem is related to performance or memory**, include valid numbers.
* **If the problem wasn't triggered by a specific action**, describe what you were doing before the problem happened and share more information using the guidelines below.

Provide more context by answering these questions:

* **Can you reproduce the problem in [the test sites](https://www.idempiere.org/test-sites)?**
* **Did the problem start happening recently** (e.g. after updating to a new version of iDempiere) or was this always a problem?
* If the problem started happening recently, **can you reproduce the problem in an older version of iDempiere?** What's the most recent version in which the problem doesn't happen?
* **Can you reliably reproduce the issue?** If not, provide details about how often the problem happens and under which conditions it normally happens.

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for iDempiere, including completely new features and 
minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your 
suggestion :pencil: and find related suggestions :mag_right:.

Before creating enhancement suggestions, please check [this list](#before-submitting-an-enhancement-suggestion) as you might 
find out that you don't need to create one. When you are creating an enhancement suggestion, please [include as many details as possible](#how-do-i-submit-a-good-enhancement-suggestion). 

#### Before Submitting An Enhancement Suggestion

* Suggest your change in the [public forum](https://www.idempiere.org/forums), do not open an issue on JIRA until you have collected positive feedback about the change. JIRA issues are primarily intended for bug reports and fixes.
* **Check if there's already [a ticket](https://idempiere.atlassian.net/browse/IDEMPIERE-3978?jql=issuetype%20in%20(Improvement%2C%20%22New%20Feature%22)%20AND%20text%20~%20%22quick%20info%22) which provides or suggests that enhancement.**

#### How Do I Submit A (Good) Enhancement Suggestion?

Enhancement suggestions are tracked as [JIRA issues](https://idempiere.atlassian.net/issues/). 

* **Use a clear and descriptive title** for the issue to identify the suggestion.
* **Provide a step-by-step description of the suggested enhancement** in as many details as possible.
* **Provide specific examples to demonstrate the steps**. 
* **Describe the current behavior** and **explain which behavior you expected to see instead** and why.
* **Explain why this enhancement would be useful** to most iDempiere users and isn't something that can or should be implemented as a [community plugin](https://wiki.idempiere.org/en/Category:Available_Plugins).

### **Did you write a patch that fixes a bug or adds and enhancement?**

* Attach your patch to the corresponding JIRA ticket or create a pull request and link it to the JIRA ticket.
* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.
* Before submitting, please read the [Contributing to iDempiere's core](https://wiki.idempiere.org/en/Contributing_to_Trunk) guide to know more about coding conventions, guidelines and benchmarks.
* If the change is big and adds new functionality, please document the modifications and new features and add this documentation to [the new features wiki](https://wiki.idempiere.org/en/Category:New_Features).

### **Did you write a plugin that is valuable for the community?**

* Read our [Plugin guidelines](https://wiki.idempiere.org/en/Plugin_Guidelines).
* Add your plugin to the [available plugins site](https://wiki.idempiere.org/en/Category:Available_Plugins).
**Note:** If the community or its leaders find that your plugin do not follow the guidelines, it's disrupting or needs further support from a specific implementing company to use it. The project leaders are entitled to remove the plugin from the Available plugins list.

### **Do you have questions about the source code?**

* Ask any question about how to use iDempiere in the [public forum](https://www.idempiere.org/forums).

### **Do you want to contribute to the iDempiere documentation?**

* Please read Contributing to iDempiere Documentation.

iDempiere is a community-driven open source project and it is a volunteer effort. We encourage you to pitch in and [join the team](https://github.com/idempiere/idempiere/graphs/contributors)!

Thanks! 

The iDempiere team
