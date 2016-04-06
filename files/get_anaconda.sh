HOME=/home/condauser

Anaconda=https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda3-4.0.0-Linux-x86.sh
if [ ! /tmp/Anaconda.sh ];
then
	wget $Anaconda -O $HOME/Anaconda.sh
else
	cp /tmp/Anaconda.sh $HOME/Anaconda.sh
fi

chown condauser:condauser $HOME/Anaconda.sh
