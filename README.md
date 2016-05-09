# БД для кассы аэропорта

Исходными данными для работы системы являются:
- номер авиарейса
- периодичность
- конечный пункт назначения
- дата и время отправления
- число мест

Кассир вводит в систему информацию от пассажира: дата, номер рейса, пункт
назначения, количество мест. Если система находит места, отвечающие запросу, то
она должна выдать информацию о номере места, количестве и типе мест. Если же
запрос удовлетворить нельзя, то ищется альтернативный вариант. Система должна
выдавать сводную справку по каждому аэропорту о наличии свободных мест на
день, запрашиваемый пассажиром.


Дополнительная информация в [info.pdf](./info.pdf)

Cкрипт, показывающий свободные места: [free_seat.sql](./queries/free_seat.sql)

[EER Diagram](./EER_Diagram.mwb)

