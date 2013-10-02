#!/bin/bash
nohup java -jar h2/bin/h2*.jar org.h2.tools.Server -tcpAllowOthers &
