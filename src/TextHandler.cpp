#include "TextHandler.h"

#include <QFile>
#include <QTextCodec>
#include <QTextDocument>
#include <QFileInfo>

#include "TextReader.h"

#include <QThread>
#include <QDebug>

QString TextHandler::getLine(int lineNumber)
{
    if (m_fileUrl.isEmpty()) return QString();

    if (m_textData.size() < static_cast<size_t>(lineNumber)) return QString();

    return QString(m_textData.at(static_cast<size_t>(lineNumber) - 1));
}

int TextHandler::numberOfLine()
{
    return static_cast<int>(m_textData.size());
}

TextHandler::TextHandler() :
    m_isImporting(false),
    m_fileUrl(),
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
    m_isImporting = true;
    emit fileUrlChanged();
    emit hasFileChanged();
    emit isImportingChanged();
    m_textData.clear();

    auto thread = new QThread();
    reader = new TextReader(fileUrl.toLocalFile());
    reader->moveToThread(thread);

    connect(thread, &QThread::started, reader, &TextReader::process);

    connect(reader, &TextReader::newLine, this, &TextHandler::newLine);
    connect(reader, &TextReader::progress, this, &TextHandler::threadProgressHandler);

    connect(thread, &QThread::finished, this, &TextHandler::threadFinishedHandler);
    connect(thread, &QThread::finished, thread, &QThread::deleteLater);
    connect(reader, &TextReader::finished, thread, &QThread::quit);

    emit threadStarted();
    thread->start();
}

void TextHandler::newLine(const QByteArray &newLine)
{
    m_textData.push_back(newLine);
}

void TextHandler::threadProgressHandler(int progress)
{
    emit threadProgress(progress / 100.0);
}

void TextHandler::threadFinishedHandler()
{
    reader->deleteLater();
    m_isImporting = false;
    emit isImportingChanged();
    emit threadFinished();
}

void TextHandler::stopThreadRequested()
{
    reader->stopProcess();
}

void TextHandler::exitApp()
{

}

