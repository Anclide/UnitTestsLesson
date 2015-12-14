# UnitTestsLesson

Проект содержит классы TUSEmployee(работник), TUSCompany(компания), TUSTaxman(сборщик налогов) и протокол TUSTaxesProvider. Также в проекте содержится файл тестов.

Задание: 

1) Сделать так, чтобы все существующие тесты проходили успешно.

2) Создать stub протокола TUSTaxesProvider, чтобы он возвращал заданные значения для методов.

3) Дополнить реализацию классов, чтобы и компания и работник платили налоги при выдаче зарплаты (проверить, что их сборщики налогов получили нужную сумму и что на нужную сумму увеличлись(уменьшились) их total amount). При этом используется внедренная заглушка протокола, созданная в первом пункте.

4) Проверить корректность реализации тестами.

5) (Доп. баллы)Можно сделать какую-либо операцию асинхронной и проверить либо факт вызова методов, либо корректность будущего значения.
