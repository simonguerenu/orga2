#pragma once


#include <inttypes.h>

typedef uint32_t fat32_t;
typedef uint16_t ext4_t;
typedef uint8_t ntfs_t;

typedef enum e_type {
    TypeFAT32 = 0,
    TypeEXT4 = 1,
    TypeNTFS = 2
} type_t;

typedef struct node {
    void* data;
    struct node* next;
    struct node* previous;
} node_t;

typedef struct list {
    type_t type;
    uint8_t size;
    node_t* first;
    node_t* last;
} list_t;

fat32_t* new_fat32();
fat32_t* copy_fat32(fat32_t* file);
void rm_fat32(fat32_t* file);

ext4_t* new_ext4();
ext4_t* copy_ext4(ext4_t* file);
void rm_ext4(ext4_t* file);

ntfs_t* new_ntfs();
ntfs_t* copy_ntfs(ntfs_t* file);
void rm_ntfs(ntfs_t* file);