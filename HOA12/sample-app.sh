#!/bin/bash

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

sudo cp sample_app.py tempdir/.
sudo cp -r templates/* tempdir/templates/.
sudo cp -r static/* tempdir/static/.

echo "FROM python" >> tempdir/Dockerfile

echo "RUN pip3 install --upgrade pip" >> tempdir/Dockerfile
echo "RUN pip3 install flask" >> tempdir/Dockerfile

echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile

echo "EXPOSE 8080" >> tempdir/Dockerfile

echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile

cd tempdir
sudo docker build -t sampleapp .

sudo docker run -t -d -p 8080:8080 --name samplerunning sampleapp

sudo docker ps -a
