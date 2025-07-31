#!/bin/bash

read -p "🔹 Enter IP address of kharej server: " REMOTE_IP

IFACE=$(ip route | grep default | awk '{print $5}')
VXLAN_IF="vxlan100"

# VXLAN setup
ip link add $VXLAN_IF type vxlan id 100 dev $IFACE remote $REMOTE_IP dstport 4789
ip addr add 10.123.1.1/30 dev $VXLAN_IF
ip -6 addr add fd11:1ceb:1d11::1/64 dev $VXLAN_IF
ip link set $VXLAN_IF up

# rc.local
cat <<EOF > /etc/rc.local
#!/bin/bash
ip link add $VXLAN_IF type vxlan id 100 dev $IFACE remote $REMOTE_IP dstport 4789
ip addr add 10.123.1.1/30 dev $VXLAN_IF
ip -6 addr add fd11:1ceb:1d11::1/64 dev $VXLAN_IF
ip link set $VXLAN_IF up
exit 0
EOF

chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local

echo "✅ IRAN VXLAN tunnel created to $REMOTE_IP (kharej)"
