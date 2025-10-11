# quick script to generate the caddyfile

NUM_GOUPS = 9
DOMAIN = "topologies.dev"
CF_API_KEY = ""

code_server_block = ""
code_server_base_port = 8080

grafana_block = ""
grafana_base_port = 3000

for i in range(NUM_GOUPS):
  n = i+1
  code_server_block += f"""
	@codeserver{n} host group{n}.{DOMAIN}
	handle @codeserver{n} {{
		reverse_proxy http://127.0.0.1:{n+code_server_base_port}
	}}
"""
  grafana_block += f"""
	@grafana{n} host grafana{n}.{DOMAIN}
	handle @grafana{n} {{
		reverse_proxy http://127.0.0.1:{n+grafana_base_port}
	}}
"""

caddyfile_content = f"""
*.{DOMAIN} {{
	tls {{
		dns cloudflare \"{CF_API_KEY}\"
		resolvers 1.1.1.1 9.9.9.9
	}}

	@eda host eda.{DOMAIN}
	handle @eda {{
		reverse_proxy https://127.0.0.1:9443 {{
			transport http {{
				tls_insecure_skip_verify
			}}
		}}
	}}

	@harbor host registry.{DOMAIN}
	handle @harbor {{
		reverse_proxy http://127.0.0.1:8999
	}}

	@pcap host es.{DOMAIN}
	handle @pcap {{
		reverse_proxy http://127.0.0.1:5001
	}}

  {code_server_block}
  {grafana_block}
}}
"""

print(caddyfile_content)