FROM debian:7.4

MAINTAINER Kamil Kwiek <kamil.kwiek@continuum.io>

COPY run_notebook.sh /tmp/run_notebook.sh
COPY environment.yml /tmp/environment.yml

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-4.0.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda2-4.0.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda2-4.0.0-Linux-x86_64.sh

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENV PATH /opt/conda/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN mkdir -p /home/condauser
COPY twarc_config /home/condauser/.twarc
COPY 20160328-simple-workflow.ipynb /home/condauser/20160328-simple-workflow.ipynb

RUN groupadd -r condauser && useradd -r -g condauser -d /home/condauser -s /bin/bash -c "Conda User" condauser && chown -R condauser:condauser /home/condauser

EXPOSE 8888

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
