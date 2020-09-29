#!/bin/zsh
export VAULTPATH=${0:a:h}
export ANSIBLE_VAULT_PASSWORD_FILE=${VAULTPATH}/.vault
export ANSIBLE_INVENTORY=${VAULTPATH}/hosts
export ANSIBLE_CONFIG=${VAULTPATH}/ansible.cfg

if (( ${+VAULTPATH} )); then
echo "Ansible Working Path: $VAULTPATH"
fi
if (( ${+ANSIBLE_VAULT_PASSWORD_FILE} )); then
echo "Vault PW File: $ANSIBLE_VAULT_PASSWORD_FILE"
fi
if (( ${+ANSIBLE_INVENTORY} )); then
echo "Ansible Inventory File: $ANSIBLE_INVENTORY"
fi
if (( ${+ANSIBLE_CONFIG} )); then
echo "Ansible Configuration File: $ANSIBLE_CONFIG"
fi



# Redis Fact Cache
#export ANSIBLE_CACHE_PLUGIN=redis
#export ANSIBLE_CACHE_PLUGIN_CONNECTION=127.0.0.1:6379
#export ANSIBLE_CACHE_PLUGIN_CONNECTION=10.0.10.152:6379
#export ANSIBLE_CACHE_PLUGIN_PREFIX=fact_

# JSON File Fact Cache
#export ANSIBLE_CACHE_PLUGIN=jsonfile
#export ANSIBLE_CACHE_PLUGIN_CONNECTION=fact_cache

# YAML File Fact Cache
export ANSIBLE_CACHE_PLUGIN=yaml
export ANSIBLE_CACHE_PLUGIN_CONNECTION=fact_cache


# Inventory Cache
#export ANSIBLE_INVENTORY_CACHE=True
#export ANSIBLE_INVENTORY_CACHE_PLUGIN=redis
#export ANSIBLE_INVENTORY_CACHE_PLUGIN_CONNECTION=10.0.10.152:6379
#export ANSIBLE_INVENTORY_CACHE_PLUGIN_PREFIX=inventory_

if (( ${+ANSIBLE_CACHE_PLUGIN} )); then
echo "Ansible Cache Plugin: $ANSIBLE_CACHE_PLUGIN"
fi
if (( ${+ANSIBLE_CACHE_PLUGIN_CONNECTION} )); then
echo "Ansible Cache Plugin Connection: $ANSIBLE_CACHE_PLUGIN_CONNECTION"
fi
if (( ${+ANSIBLE_CACHE_PLUGIN_PREFIX} )); then
echo "Ansible Cache Plugin Connection: $ANSIBLE_CACHE_PLUGIN_PREFIX"
fi

