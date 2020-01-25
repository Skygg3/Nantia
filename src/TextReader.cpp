#include "TextReader.h"

#include <QFile>


TextReader::TextReader(const QString &name) :
    name(name),
    stopRequested(false)
{
}

void TextReader::stopProcess()
{
    stopRequested = true;
}

void TextReader::process()
{
    stopRequested = false;

    if (QFile::exists(name))
    {
        QFile file(name);
        const auto size = file.size();
        QString buffer;
        if (file.open(QIODevice::Text | QIODevice::ReadOnly))
        {
            long long lastProgress = 0;

            while(!file.atEnd() && !stopRequested) {
                emit newLine(file.readLine());

                // Calculate new progress
                auto remains = file.bytesAvailable();
                uint progressValue = static_cast<uint>(((size - remains) * 100) / size);
                if (lastProgress != progressValue) {
                    emit progress(progressValue);
                    lastProgress = progressValue;
                    buffer.clear();
                }
            }
        }
    }

    emit finished();
}
