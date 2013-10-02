#!/bin/bash
nohup java -cp h2/bin/h2*.jar org.h2.tools.Server -tcp -tcpAllowOthers &
