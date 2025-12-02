-- sql 문 한번에 붙여넣어 실행시키면 db가 자동으로 생성됩니다
-- mysql cli 환경에서 하는걸 추천드립니다

-- 권장 공통 설정
SET NAMES utf8mb4;
SET time_zone = '+09:00';

-- 1) 핸드폰 정보

CREATE TABLE phones (
  phone_id        BIGINT AUTO_INCREMENT PRIMARY KEY,
  image_path 	  VARCHAR(255)  NULL,
  brand           VARCHAR(50)   NOT NULL,
  model           VARCHAR(100)  NOT NULL,
  price           INT NOT NULL,
  processor       VARCHAR(100) NOT NULL,
  ram             SMALLINT     NOT NULL,          -- GB
  display_info    VARCHAR(255) NOT NULL,          -- 패널/해상도/비율 등 요약
  display_inch    DECIMAL(3,1) NOT NULL,          -- 인치(예: 6.5)
  camera          VARCHAR(255) NOT NULL,          -- 전/후면 구성 요약
  battery         INT          NOT NULL,          -- mAh
  storage_gb      INT          NOT NULL,          -- 128/256/512 등
  year_of_release      INT         NOT NULL,
  connectivity    VARCHAR(255) NOT NULL,          -- 5G/Wi-Fi/NFC 등
  special_features VARCHAR(255) NOT NULL,          -- 폴더블 등 (공백 없는 컬럼명 권장)
  weight          DECIMAL(6,1)  NOT NULL,          -- g (예: 239.0)
  size            VARCHAR(60)   NOT NULL,          -- mm(예: 153.9×67.1×7.6)
  UNIQUE KEY uk_brand_model (brand, model)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2) 사용자 정보

-- 요구 필드: nickname, id, password

CREATE TABLE users (
  id             VARCHAR(50)  PRIMARY KEY,     -- 로그인 ID (이메일/닉네임과 별개로 권장)
  nickname       VARCHAR(50)  NOT NULL,
  password       VARCHAR(255) NOT NULL,        -- 해시 저장 권장(평문 금지)
  created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3) 커뮤니티 (게시글)

CREATE TABLE community_posts (
  post_id     BIGINT AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(200) NOT NULL,
  content     TEXT         NOT NULL,
  writer_id   VARCHAR(50)  NOT NULL,           -- users.id 참조
  created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  click_count INT          NOT NULL DEFAULT 0,
  CONSTRAINT fk_posts_writer
    FOREIGN KEY (writer_id) REFERENCES users(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  INDEX idx_posts_writer (writer_id),
  INDEX idx_posts_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4) 커뮤니티 댓글
-- 요구 필드: comment_id, post_id, content, writer_id, created_at

CREATE TABLE community_comments (
  comment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  post_id    BIGINT       NOT NULL,            -- community_posts.post_id 참조
  content    TEXT         NOT NULL,
  writer_id  VARCHAR(50)  NOT NULL,            -- users.id 참조
  created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_comments_post
    FOREIGN KEY (post_id) REFERENCES community_posts(post_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_comments_writer
    FOREIGN KEY (writer_id) REFERENCES users(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  INDEX idx_comments_post (post_id),
  INDEX idx_comments_writer (writer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;