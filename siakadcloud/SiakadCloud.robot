*** Settings ***
Suite Teardown    Close All Browsers
Library           Selenium2Library
Library           Collections
Library           CSVLibrary
Library           String  

*** Test Cases ***
Login
    ### read csv data for config
    @{config}=    Read Csv File To Associative    appconfig.csv
    ### heading to login page
    ${mainBrowser}=    Open Browser    &{config[0]}[url]    chrome
    Selenium2Library.Maximize Browser Window
    ### input login data and submit
    Log To Console    >>> start login for username: &{config[0]}[username]
    Selenium2Library.Wait Until Element Is Visible    //*[@id="userid"]    timeout=30s
    Selenium2Library.Input Text    //*[@id="userid"]    &{config[0]}[username]
    Selenium2Library.Input Password    //*[@id="password"]    &{config[0]}[pwd]
    Selenium2Library.Wait Until Element Is Visible    //h2[text()="Silakan Login"]/following-sibling::form/div[3]/button[1]
    Selenium2Library.Click Element    //h2[text()="Silakan Login"]/following-sibling::form/div[3]/button[1]
    ### wait until landed to homepage
    Selenium2Library.Wait Until Element Is Visible    //ul[@id="navigation"]/li[1]    timeout=30s
    Log To Console    >>> username &{config[0]}[username] logged in successfully

Enter Presensi Kelas
    ### pre defined variables
    ${periode}=    Set Variable    20191
    ${kurikulum}=    Set Variable    2019
    ${kode}=    Set Variable    7172
    ### input sim akademik page
    Selenium2Library.Double Click Element    //ul[@id="navigation"]/li[1]
    Selenium2Library.Double Click Element    //*[@id="navigation"]/li[1]/div[2]
    Selenium2Library.Wait Until Element Is Visible    //*[@id="siakad"]/div/div    timeout=30s
    Selenium2Library.Click Element    //*[@id="siakad"]/div/div
    ### enter kelas kuliah menu
    Selenium2Library.Wait Until Element Is Visible    //li[@class="dropdown"][2]/a    timeout=30s
    Selenium2Library.Click Element    //li[@class="dropdown"][2]/a
    Selenium2Library.Click Element    //li[@class="dropdown"][2]/ul/li[2]/a
    Selenium2Library.Click Element    //li[@class="dropdown"][2]/ul/li[2]/ul/li
    Selenium2Library.Wait Until Element Is Visible    //*[@id="form_list"]/div[1]/table/tbody/tr/td[11]/button    timeout=30s
    Log to console    >>> landed on kelas kuliah page
    ### choose periode akademik
    Selenium2Library.Select From List By Value    //select[@id="periode"]    ${periode}
    ### choose kurikulum
    Selenium2Library.Select From List By Value    //select[@id="kurikulum"]    ${kurikulum}
    ### validate kolom kode (kode mata kuliah)
    Selenium2Library.Wait Until Element Is Visible    //*[@id="form_list"]/div[1]/table/tbody/tr    timeout=30s
    ${kode_matkul}=    Selenium2Library.Get Text    //*[@id="form_list"]/div[1]/table/tbody/tr/td[2]
    Should Be Equal As Strings    ${kode_matkul}    ${kode}    ignore_case=True
    Log To Console    >>> kode matkul: ${kode} found.
    ### click actions
    Selenium2Library.Click Element    //*[@id="form_list"]/div[1]/table/tbody/tr/td[11]/div/button
    Selenium2Library.Wait Until Element Is Visible    //a[text()="Presensi Kelas"]    timeout=30s
    Selenium2Library.Click Element    //a[text()="Presensi Kelas"]
    Page Should Contain Element    //*[@id="header-search"]/div/div[2]/button[2]
    Log To Console    >>> Landed on Presensi Kelas page. Periode ${periode}. Kurikulum ${kurikulum}. Kode ${kode}
    Sleep    5s
    # Isi Absensi
    #    ### pre defined variables
    #    ${jadwal}=    Set Variable    Selasa, 20 Agu 2019
    #    ### pre defined variables buat contoh
    #    @{data}=    Read Csv File To Associative    test.csv
    #    ### open presensi kelas popup
    #    Log To Console    >>> Opening presensi kelas popup: ${jadwal}
    #    Log To Console    >>> Data = &{data[0]}[nim]
    #    Selenium2Library.Wait Until Element Is Visible    //button[@data-tgljadwal="2019-08-20"]
    #    Selenium2Library.Click ELement    //button[@data-tgljadwal="2019-08-20"]
    #    Selenium2Library.Wait Until Element Is Visible    //td[text()="&{data[0]}[nim]"]    timeout=30s
    #    Selenium2Library.Select From List By Value    //td[text()="${nim}"]/following-sibling::td[2]/span/select    ${presensi}
    #    Selenium2Library.Wait Until Element Is Visible    //td[text()="${nim2}"]    timeout=30s
    #    Selenium2Library.Select From List By Value    //td[text()="${nim2}"]/following-sibling::td[2]/span/select    ${presensi2}
    #    Log To Console    >>> presensi kelas popup opened.
    #    ### pick student nim and assign presence data
    #    Sleep    10s

Test
    ### pre defined variables
    ${jadwal}=    Set Variable    Selasa, 20 Agu 2019
    ### pre defined variables buat contoh
    @{data}=    Read Csv File To Associative    test.csv
    ### open presensi kelas popup
    Log To Console    >>> Opening presensi kelas popup: ${jadwal}
    # Log To Console    >>> Data = &{data[0]}[nim]
    Selenium2Library.Wait Until Element Is Visible    //tr[1]//td[10]//button[1]    30s
    Double Click ELement    //tr[1]//td[10]//button[1]
    Selenium2Library.Wait Until Element Is Visible    //table[@id='table_mhs']/tbody/tr    60s
    ${rows}=    Get Element Count    //table[@id='table_mhs']/tbody/tr/td[2]
    ${cols}=    Get Element Count    //table[@id='table_mhs']/thead/tr/th
    Selenium2Library.Wait Until Element Is Visible    //table[@id='table_mhs']//tbody/tr[1]/td[2]   60s
    Log To Console    >>>rows = ${rows}
    Log To Console    >>>cols = ${cols}
    ${separator1}=   Set Variable        ,
    ${separator2}=   Set Variable        s.d
    ${dosen}=      Get Text    //table[@id='table_dosen']/tbody/tr/td[3]
    ${kapan}=      Get Text    //span[@id='span_jadwal']
    ${kode}=       Get Text    //*[@id="modal_list"]/div/div/div[1]/div/div[1]/div[2]
    Log To Console    >>>dosen = ${dosen}
    Log to Console    >>>kode = ${kode}
    
    ${pisah}=           Split String From Right    ${kapan}    ${separator1}     1
    Log to Console    ${pisah}
    ${pisahjam}=        Split String    ${pisah[1]}     ${separator2}
    ${tgl}=         Set Variable    ${pisah[0]}
    ${mulai}=       Set Variable   ${pisahjam[0]}
    ${selesai}=     Set Variable   ${pisahjam[1]}
    Log to Console    >>>tanggal: ${tgl}   
    Log to Console    >>>Mulai: ${mulai}
    Log to Console    >>>Selesai: ${selesai}
    #Lihat data mahasiswa
    ${data1}    Create List
    ${data2}    Create List
    ${data3}    Create List
    # ${coba}     Create List    
    FOR    ${i}    IN RANGE    1    ${rows}
        ${nim}=          Get Text    //table[@id='table_mhs']/tbody/tr[${i}]/td[2]
        ${identitas}=    Get Text    //table[@id='table_mhs']/tbody/tr[${i}]/td[3]
        ${kehadiran}=    Get Text    //table[@id='table_mhs']/tbody/tr[${i}]/td[4]
        # ${semua}=        Get Text    //table[@id='table_mhs']/tbody/tr[${i}]/td[2,3,4]
        Append to List    ${data1}     ${nim}
        Append to List    ${data2}     ${identitas}
        Append to List    ${data3}     ${kehadiran}
        # CSVLibrary.Append to CSV File     test.csv      ${nim}
        # CSVLibrary.Append to CSV File     test.csv      ${identitas}
        # CSVLibrary.Append to CSV File     test.csv      ${kehadiran}
        # Append to List    ${coba}      ${semua}    
    END



    FOR     ${i}    IN RANGE    0   ${rows}-1
        ${akhir}        Create List     ${data1[${i}]}   ${data2[${i}]}   ${data3[${i}]}
        ${akh}          Create List     ${akhir}
        CSVLibrary.Append To CSV File     test.csv    ${akh}
    END

    ${informasi}    Create List     ${kode}     ${tgl}  ${mulai}    ${selesai}
    ${info}         Create List     ${informasi}     
    # ${gabungan}     Create List     ${coba}
    # CSVLibrary.Append To CSV File     test.csv      ${akhir}
    CSVLibrary.Append To CSV File     jadwal.csv    ${info}
    # Log to Console      >>>coba = ${gabungan}
    ### pick student nim and assign presence data
    Sleep    10s

# test read csv
#     @{list}=    Read Csv File To List    appconfig.csv
#     Log    hasil read csv file to list: ${list[0]}
#     ### baca test.csv
#     Comment    @{test}=    Read Csv File To Associative    test.csv
#     @{test}=    Read Csv File To List    test.csv
#     FOR    ${key}    IN    @{test}
#     Log    nim: ${key[0]}
#     Log    presence: ${key[1]}
