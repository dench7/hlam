echo "============================================================"
echo "Setup NodeName:"
echo "============================================================"
read NODENAME
echo 'export NODENAME='${NODENAME} >> $HOME/.bash_profile
source ~/.bash_profile

echo "============================================================"
echo "SUBSPACE_ADDRESS:"
echo "============================================================"
read SUBSPACE_ADDRESS
echo 'export SUBSPACE_ADDRESS='${SUBSPACE_ADDRESS} >> $HOME/.bash_profile
source ~/.bash_profile
