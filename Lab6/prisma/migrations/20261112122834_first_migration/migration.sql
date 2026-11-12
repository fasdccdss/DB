-- CreateEnum
CREATE TYPE "category" AS ENUM ('Science', 'Politics', 'Technology');

-- CreateEnum
CREATE TYPE "categoryenum" AS ENUM ('Science', 'Politics', 'Technology');

-- CreateEnum
CREATE TYPE "languageenum" AS ENUM ('Ukrainian', 'English', 'Chinese');

-- CreateTable
CREATE TABLE "article_categories" (
    "topic" VARCHAR(100) NOT NULL,
    "language" "languageenum" NOT NULL,
    "category" "categoryenum" NOT NULL,

    CONSTRAINT "article_categories_pkey" PRIMARY KEY ("topic","language","category")
);

-- CreateTable
CREATE TABLE "article_revisions" (
    "relative_index" SERIAL NOT NULL,
    "topic" VARCHAR(100) NOT NULL,
    "language" "languageenum" NOT NULL,
    "date" DATE NOT NULL,
    "user_id" INTEGER,
    "content" TEXT NOT NULL,

    CONSTRAINT "article_revisions_pkey" PRIMARY KEY ("topic","language","relative_index")
);

-- CreateTable
CREATE TABLE "article_sources" (
    "topic" VARCHAR(100) NOT NULL,
    "language" "languageenum" NOT NULL,
    "source_url" VARCHAR(1000) NOT NULL,

    CONSTRAINT "article_sources_pkey" PRIMARY KEY ("topic","language","source_url")
);

-- CreateTable
CREATE TABLE "articles_normalized" (
    "topic" VARCHAR(100) NOT NULL,
    "language" "languageenum" NOT NULL,

    CONSTRAINT "articles_normalized_pkey" PRIMARY KEY ("topic","language")
);

-- CreateTable
CREATE TABLE "sources" (
    "url" VARCHAR(1000) NOT NULL,

    CONSTRAINT "sources_pkey" PRIMARY KEY ("url")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_name_key" ON "users"("name");

-- AddForeignKey
ALTER TABLE "article_categories" ADD CONSTRAINT "article_categories_topic_language_fkey" FOREIGN KEY ("topic", "language") REFERENCES "articles_normalized"("topic", "language") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "article_revisions" ADD CONSTRAINT "article_revisions_topic_language_fkey" FOREIGN KEY ("topic", "language") REFERENCES "articles_normalized"("topic", "language") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "article_revisions" ADD CONSTRAINT "article_revisions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "article_sources" ADD CONSTRAINT "article_sources_source_url_fkey" FOREIGN KEY ("source_url") REFERENCES "sources"("url") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "article_sources" ADD CONSTRAINT "article_sources_topic_language_fkey" FOREIGN KEY ("topic", "language") REFERENCES "articles_normalized"("topic", "language") ON DELETE NO ACTION ON UPDATE NO ACTION;
