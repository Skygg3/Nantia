#include "TextHandler.h"

#include <QFile>
#include <QTextCodec>
#include <QTextDocument>
#include <QFileInfo>

TextHandler::TextHandler()
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

    QString filePath = fileUrl.toLocalFile();

    if (QFile::exists(filePath))
    {
        QFile file(filePath);
        if (file.open(QIODevice::Text | QIODevice::ReadOnly))
        {
            QString content = QString::fromUtf8(file.readAll());

            emit loaded(content);
        }
    }

    m_fileUrl = fileUrl;
    emit fileUrlChanged();
}
