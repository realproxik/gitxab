// index.h
#ifndef INDEX_H
#define INDEX_H

#include <string>
#include <vector>
#include <sys/stat.h>

struct IndexEntry {
    std::string path;
    std::string sha1;
    uint32_t mode;
    uint32_t uid;
    uint32_t gid;
    uint32_t size;
    uint32_t mtime_sec;
    uint32_t mtime_nsec;
    uint32_t ctime_sec;
    uint32_t ctime_nsec;
    uint16_t flags;
};

std::vector<IndexEntry> read_index();
void write_index(const std::vector<IndexEntry>& entries);
void add_to_index(const std::string& path, const std::string& sha1, uint32_t mode, const struct stat& st);

#endif
