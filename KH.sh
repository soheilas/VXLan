#!/bin/bash

read -p "🛰️  Enter IP of iran server: " REMOTE_IP
IFACE=$(ip route | grep default | awk '{print $5}')
VXLAN_IF="vxlan100"

# Interface
ip link add $VXLAN_IF type vxlan id 100 dev $IFACE remote $REMOTE_IP dstport 4789
ip addr add 10.123.1.2/30 dev $VXLAN_IF
ip -6 addr add fd11:1ceb:1d11::2/64 dev $VXLAN_IF
ip link set $VXLAN_IF up

# Create rc.local
cat <<EOF > /etc/rc.local
#!/bin/bash
ip link add $VXLAN_IF type vxlan id 100 dev $IFACE remote $REMOTE_IP dstport 4789
ip addr add 10.123.1.2/30 dev $VXLAN_IF
ip -6 addr add fd11:1ceb:1d11::2/64 dev $VXLAN_IF
ip link set $VXLAN_IF up
exit 0
EOF

chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local

echo "✅ VXLAN setup on KHAREJ completed (IPv4: 10.123.1.2 / IPv6: fd11:1ceb:1d11::2)"
