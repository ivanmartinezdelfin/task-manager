CREATE TABLE app_user (
    id uuid PRIMARY KEY,
    email text NOT NULL,
    password_hash text NOT NULL,
    role text NOT NULL DEFAULT 'USER',
    created_at timestamptz NOT NULL DEFAULT now(),

    CONSTRAINT uq_app_user_email UNIQUE (email),
    CONSTRAINT chk_role CHECK (role IN ('USER', 'ADMIN')),
    CONSTRAINT chk_email_len CHECK (char_length(email) BETWEEN 3 AND 320)
);

CREATE TABLE task (
    id uuid PRIMARY KEY,
    user_id uuid NOT NULL REFERENCES app_user(id) ON DELETE CASCADE,
    title text NOT NULL,
    description text,
    status text NOT NULL DEFAULT 'TODO',
    due_date timestamptz,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),

    CONSTRAINT chk_title_len CHECK (char_length(title) BETWEEN 1 AND 200),
    CONSTRAINT chk_desc_len CHECK (char_length(description) <= 2000),
    CONSTRAINT chk_status CHECK (status IN ('TODO', 'IN_PROGRESS', 'DONE'))
);

CREATE INDEX idx_task_user_id ON task(user_id);
CREATE INDEX idx_task_user_status ON task(user_id, status);
CREATE INDEX idx_task_user_due_date ON task(user_id, due_date);
CREATE INDEX idx_task_user_due_id ON task(user_id, due_date, id);