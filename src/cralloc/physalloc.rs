use {
    crate::map_page,
    x86_64::structures::paging::Page,
    core::ptr::{read_volatile, write_volatile},
    // TODO
};

// Implementation objective: use map_page! macro along with more test pages to create physical mappings,
// then use read_volatile and write_volatile to actually perform operations
// Completion ETA: 8/13/2022 4PM PDT (UTC-7)