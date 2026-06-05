CXX = g++
CXXFLAGS = -std=c++11 -O2 -Wall
LDFLAGS = -lz

TARGET = git-core
SRCS = src/sha1.cpp src/zlib_util.cpp src/object.cpp src/index.cpp src/refs.cpp src/git.cpp
OBJS = $(SRCS:.cpp=.o)

.PHONY: all clean install

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $(TARGET) $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)

install: $(TARGET)
	cp $(TARGET) /usr/local/bin/
	cp scripts/git-* /usr/local/bin/
	cp perl/git-*.pl /usr/local/bin/