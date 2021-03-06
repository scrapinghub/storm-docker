(defproject storm-deps "0.0.1-SNAPSHOT"
  :min-lein-version "2.0.0"
  :dependencies [ [org.apache.storm/storm-core "0.9.4"]
                  [org.apache.storm/storm-kafka "0.9.4"
                   :exclusions [org.slf4j/slf4j-api]]
                  [org.apache.kafka/kafka_2.9.2 "0.8.2.1"
                   :exclusions [com.sun.jmx/jmxri com.sun.jdmk/jmxtools javax.jms/jms org.slf4j/slf4j-api]]
                  [org.apache.zookeeper/zookeeper "3.4.6"
                   :exclusions [io.netty/netty org.slf4j/slf4j-api org.slf4j/slf4j-log4j12]]
                  [com.parsely/streamparse "0.0.4-SNAPSHOT"]
                  [org.msgpack/msgpack "0.6.11"]
                 ]
  :jar-exclusions     [#"log4j\.properties" #"backtype" #"META-INF" #"meta-inf" #"\.yaml"]
  :uberjar-exclusions [#"log4j\.properties" #"backtype" #"META-INF" #"meta-inf" #"\.yaml"]
  )
