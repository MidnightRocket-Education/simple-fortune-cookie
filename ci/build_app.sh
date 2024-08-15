#!/bin/sh
cd ../frontend
go build -o goapp

cd ../backend
go build -o goapp
