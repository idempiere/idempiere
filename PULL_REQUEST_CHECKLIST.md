# Pull Request Checklist

## Follow the project code guidelines.

Please read carefully the [Contributing to Core](https://wiki.idempiere.org/en/Contributing_to_Trunk) guidelines before starting the development. 

This is a list of the common issues, standards and guidelines when contributing to iDempiere's core. Following all the recommendations will make the merging process smoother for everyone involved.

## Description

Please include the link to the corresponding JIRA ticket in the description. This gives the peer reviewers relevant information and context on what's needed for the change.

## Run the unit tests.

* Make sure the changes you want to commit pass all the core unit tests. 
* If the new code does not pass a unit test because the unit test was wrong, fix the unit test in the same pull request.
* If you're adding something new, please add the corresponding unit test.

You can learn more about unit tests in iDempiere with this [video](https://www.youtube.com/watch?v=bO71gw3is5I).

## Checklist:

- [ ] My code follows the code guidelines of this project
- [ ] My code follows the best practices of this project
- [ ] I have performed a self-review of my own code
- [ ] My code is easy to understand and review. 
- [ ] In hard-to-understand areas, I have commented my code.
- [ ] My changes generate no new warnings
- [ ] New and existing unit tests pass locally with my changes
- [ ] I have added unit tests that prove my fix is effective or that my feature works
- [ ] Any dependent changes have been merged and published in downstream modules
- [ ] I have checked my code and corrected any misspellings
- [ ] I have made corresponding changes to the documentation as follows:
- - [ ] New feature (non-breaking change which adds functionality): I have created the New Feature page in the project wiki explaining the functionality and how to use it. If relevant, I have committed sample data to the core seed to have usable examples in GardenWorld.
- - [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected): I have documented the change in a clear way that everyone in the community can understand the impact of the change.
- - [ ] Improvement (improves and existing functionality): This documentation is needed if the improvement changes the way the user interacts with the system or the outcome of a process/task changes. If it is just, for instance, a performance improvement, documentation might not be needed. 
- [ ] The changed/added documentation is in the project wiki (not privately-hosted pdf files or links pointing to a company website) and is complete and self-explanatory.

