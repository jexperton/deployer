| build status | tag | image | from |
| ------------ | --- | ----- | :---- |
| [![Build Status](https://travis-ci.org/jexperton/deployer.svg?branch=6)](https://travis-ci.org/jexperton/deployer) | ```6``` | [Dockerfile](https://github.com/jexperton/deployer/blob/6) | [jexperton/7.2-cli](https://github.com/jexperton/php/blob/7.2-cli/Dockerfile) |

## Usage

```bash
cat <<EOF > dep
#!/bin/sh
docker run --rm \\
    -u $(id -u):$(id -g) \\
    -v $(pwd):/src:cached \\
    -w /src \\
    -e PRIVATE_KEY="\$(openssl rsa -in $HOME/.ssh/id_rsa | base64 -w 0)" \\
    jexperton/deployer:6 "\$@"
EOF
```
```
chmod +x dep
```

```
./dep deploy staging
```

