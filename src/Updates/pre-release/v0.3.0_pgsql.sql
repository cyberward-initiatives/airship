ALTER TABLE airship_users ADD gpg_public_key TEXT;
ALTER TABLE airship_users ADD allow_reset BOOLEAN DEFAULT FALSE;

CREATE TABLE airship_user_recovery (
    tokenid BIGSERIAL PRIMARY KEY,
    userid BIGINT REFERENCES airship_users(userid),
    selector TEXT,
    hashedtoken TEXT,
    created TIMESTAMP DEFAULT NOW(),
    modified TIMESTAMP DEFAULT NOW()
);
CREATE INDEX ON airship_user_receovery (selector);

DROP TRIGGER IF EXISTS update_airship_user_recovery_modtime ON airship_user_recovery;
CREATE TRIGGER update_airship_user_recovery_modtime
  BEFORE UPDATE ON airship_user_recovery
  FOR EACH ROW EXECUTE PROCEDURE update_modtime();