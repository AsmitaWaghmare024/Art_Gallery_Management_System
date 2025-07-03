-- Table: artist
COMMENT ON TABLE artist IS 'Stores artist details for each registered painter.';
COMMENT ON COLUMN artist.artist_id IS 'Primary key for each artist.';
COMMENT ON COLUMN artist.name IS 'Full name of the artist.';
COMMENT ON COLUMN artist.address IS 'Residential location.';
COMMENT ON COLUMN artist.phone IS '10-digit contact number, validated.';
COMMENT ON COLUMN artist.is_deleted IS 'Soft delete flag.';
COMMENT ON COLUMN artist.created_at IS 'Timestamp when record was created.';
COMMENT ON COLUMN artist.updated_at IS 'Timestamp of last update.';

-- Table: painting
COMMENT ON TABLE painting IS 'Holds data for all paintings, including type, artist, and sale info.';
COMMENT ON COLUMN painting.title IS 'Name of the painting.';
COMMENT ON COLUMN painting.type_id IS 'FK to painting_type.';
COMMENT ON COLUMN painting.painted_by IS 'FK to artist_id.';
COMMENT ON COLUMN painting.likes_pct IS 'Popularity score (0–100%).';
COMMENT ON COLUMN painting.sold_flag IS 'Y if sold, N if unsold.';
COMMENT ON COLUMN painting.is_deleted IS 'Y if marked soft-deleted.';

--View Comments
COMMENT ON VIEW vw_painting_details IS 'Comprehensive painting info including type, artist, and gallery.';
COMMENT ON VIEW vw_customer_purchases IS 'View of customer purchase history with artist and painting details.';
COMMENT ON VIEW vw_exhibition_summary IS 'Lists total and sold paintings per exhibition.';

--Sequence Comments
COMMENT ON SEQUENCE audit_seq IS 'Auto-increments audit_id for audit trail.';
COMMENT ON SEQUENCE validation_log_seq IS 'Used to populate validation_log.primary key.';
COMMENT ON SEQUENCE error_log_seq IS 'Used for assigning IDs to runtime errors.';
COMMENT ON SEQUENCE data_audit_seq IS 'Tracks soft deletes and sensitive updates.';