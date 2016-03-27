#!/bin/bash -u

bundle exec reversible_cryptography encrypt --src-file=private/secret.yaml --dst-file=properties/secret.yaml.encrepted
