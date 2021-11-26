FROM continuumio/anaconda3:2021.04
SHELL [ "/bin/bash", "--login", "-c" ]
ARG UID=1000
ARG GID=1000

# Update conda
RUN conda update -n base -c defaults conda # Updating conda can take a while...

# Dependencies
# RUN apt-get update && apt-get install -y \
#     ffmpeg \
#     build-essential

# Create non-root user
RUN groupadd -g ${GID} -o user
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash user
RUN mkhomedir_helper user
USER user

# Create conda environment
WORKDIR /home/user
COPY ./environment.yml /home/user/environment.yml
RUN conda env create -f environment.yml --quiet # Creating a conda environment can take a while...

# Install pip requirements
COPY ./requirements.txt /home/user/requirements.txt
RUN conda activate conda_environment && \
    pip install -r requirements.txt

COPY ./setup/entrypoint.sh /home/user/entrypoint.sh
# The directory below should be where you mount
# your code when running this container
WORKDIR /home/user/workspace
ENTRYPOINT ["/home/user/entrypoint.sh"]
