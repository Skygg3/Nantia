#include "TextHandler.h"

#include <QFile>
#include <QTextCodec>
#include <QTextDocument>
#include <QFileInfo>

#include "TextReader.h"

#include <QThread>

TextHandler::TextHandler() :
    reader(nullptr)
{

}

QString TextHandler::fileName() const
{
    const QString filePath = m_fileUrl.toLocalFile();
    const QString fileName = QFileInfo(filePath).fileName();
    if (fileName.isEmpty())
        return QStringLiteral("untitled.txt");
    return fileName;
}

void TextHandler::load(const QUrl &fileUrl)
{
    if (fileUrl == m_fileUrl) return;
    m_fileUrl = fileUrl;

    QThread *thread = new QThread();
    reader = new TextReader(fileUrl.toLocalFile());
    reader->moveToThread(thread);

    connect(thread, &QThread::started, reader, &TextReader::process);

    connect(reader, &TextReader::progress, this, &TextHandler::threadProgressHandler);

    connect(thread, &QThread::finished, this, &TextHandler::threadFinishedHandler);
    connect(thread, &QThread::finished, thread, &QThread::deleteLater);
    connect(reader, &TextReader::finished, thread, &QThread::quit);
    connect(reader, &TextReader::finished, reader, &TextReader::deleteLater);

    emit threadStarted();
    thread->start();
}

void TextHandler::threadProgressHandler(int progress, const QString &line)
{
    emit threadProgress(progress / 100.0, line);
}

void TextHandler::threadFinishedHandler()
{
    emit threadFinished();
}
