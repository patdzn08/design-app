#!/bin/bash

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp login-app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  login-app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python /home/myapp/login-app.py" >> tempdir/Dockerfile

cd tempdir
docker build -t loginapp .
docker run -t -d -p 5050:5050 --name loginrunning loginapp
docker ps -a 