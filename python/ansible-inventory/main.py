import ansinv
import argparse

parser = argparse.ArgumentParser(description='Generates ansible inventory file based on provided hosts.')
parser.add_argument('--inv-path', dest='inv_path', type=str, default='./inventory.conf',
                    help='Path were inventory file will be stored.')
parser.add_argument('--nomad-servers', dest='nomad_servers', metavar='host', type=str, nargs='+',
                    help='host that must be included to '
                         'nomad_servers.')
parser.add_argument('--nomad-clients', dest='nomad_clients', metavar='host', type=str, nargs='+',
                    help='host that must be included to '
                         'nomad_clients.')
parser.add_argument('--vault-instances', dest='vault_instances', metavar='host', type=str, nargs='+',
                    help='host that must be included to '
                         'vault_instances.')

args = parser.parse_args()


def create_simple_node(host: str):
    ansible_host = ansinv.AnsibleHost(host)

    return ansible_host


def create_nomad_instance(host: str, node_type: str, index: int):
    ansible_host = ansinv.AnsibleHost(host)

    if node_type not in ['client', 'server']:
        raise Exception('Incorrect type provided: ' + node_type)

    ansible_host.hostvars['nomad_node_role'] = node_type
    ansible_host.hostvars['nomad_node_name'] = f'nomad-{node_type}-{index}'

    return ansible_host


def create_consul_instance(host: str, node_type: str):
    ansible_host = ansinv.AnsibleHost(host)

    if node_type == 'client':
        ansible_host.hostvars['consul_node_role'] = 'client'
    elif node_type == 'server':
        ansible_host.hostvars['consul_node_role'] = 'server'
        ansible_host.hostvars['consul_bootstrap_expect'] = 'true'
    else:
        raise Exception('Incorrect type provided: ' + node_type)

    return ansible_host


inventory = ansinv.AnsibleInventory()
ansible_groups = []
args_groups = [
    ('nomad_servers', args.nomad_servers, create_simple_node),
    ('nomad_clients', args.nomad_clients, create_simple_node),
    ('vault_instances', args.vault_instances, create_simple_node),
    ('vault_raft_servers', args.vault_instances, create_simple_node),
]

nomad_instances = [create_nomad_instance(host, 'server', index) for index, host in enumerate(args.nomad_servers)] \
                  + [create_nomad_instance(host, 'client', index) for index, host in enumerate(args.nomad_clients)]

consul_instances = [create_consul_instance(host, 'server') for host in args.nomad_servers] \
                   + [create_consul_instance(host, 'client') for host in args.nomad_clients] \
                   + [create_consul_instance(host, 'client') for host in args.vault_instances]

args_groups.append(('nomad_instances', nomad_instances, None))
args_groups.append(('consul_instances', consul_instances, None))

try:
    for group, hosts, callback in args_groups:
        ansible_group = ansinv.AnsibleGroup(group)

        for host in hosts:
            if callback:
                ansible_group.add_hosts(callback(host))
            else:
                ansible_group.add_hosts(host)

        ansible_groups.append(ansible_group)
except TypeError:
    raise Exception('Error. Not all groups are provided.')

inventory.add_groups(*ansible_groups)

with open(args.inv_path, "w") as f:
    f.write(str(inventory))

print('Inventory generated in path: ' + args.inv_path)
