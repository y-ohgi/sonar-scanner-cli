yohgi/sonar-qube-cli
---

# About
Dockerize to speed up the scan of SonarQube

# Usage
## Manual upload
```
$ docker run -v `pwd`:/scan yohgi/sonar-qube-cli \
    -Dsonar.host.url=<https://sonarqube.example.com> \
    -Dsonar.login=${SONAR_TOKEN} \
    -Dsonar.projectVersion=${CIRCLE_BUILD_NUM} \
    -Dsonar.projectName=${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME} \
    -Dsonar.projectKey=${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}
```

## CircleCI
```yaml
version: 2

jobs:
  sonarqube_push:
    docker:
      - image: yohgi/sonar-scanner-cli
    steps:
      - checkout
      - run:
          name: scan
          command: |
            [[ "$CIRCLE_PULL_REQUEST" ]] || exit 0
            sonar-scanner \
              -Dsonar.host.url=<https://sonarqube.example.com> \
              -Dsonar.login=${SONAR_TOKEN} \
              -Dsonar.projectName=${CIRCLE_PROJECT_REPONAME} \
              -Dsonar.projectVersion=${CIRCLE_BUILD_NUM} \
              -Dsonar.projectName=${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME} \
              -Dsonar.projectKey=${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}

workflows:
  version: 2
  sonarqube_push:
    jobs:
      - sonarqube_push
          filters:
            branches:
              only:
                - develop
```
