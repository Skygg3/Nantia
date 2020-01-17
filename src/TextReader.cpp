#include "TextReader.h"

#include <QFile>


TextReader::TextReader(const QString &name) :
    name(name)
{

}

void TextReader::process()
{
    fileContent.clear();

    if (QFile::exists(name))
    {
        QFile file(name);
        const auto size = file.size();
        long long lastProgress = 0;
        QString buffer;
        if (file.open(QIODevice::Text | QIODevice::ReadOnly))
        {
            while(!file.atEnd()) {
                buffer += file.readLine();

                auto remains = file.bytesAvailable();
                auto progressValue = ((size - remains) * 100) / size;
                if (lastProgress != progressValue) {
                    emit progress(progressValue, buffer);
                    lastProgress = progressValue;
                    buffer.clear();
                }
                //fileContent = QString::fromUtf8(file.readAll());
            }
        }
    }

    emit finished();
}
