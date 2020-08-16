import React, {useState, FormEvent} from 'react';
import { useHistory } from 'react-router-dom';
import PageHeader from '../../components/PageHeader';
import Input from '../../components/Input';
import TextArea from '../../components/TextArea';
import Select from '../../components/Select';

import warningIcon from '../../assets/images/icons/warning.svg';

import api from '../../services/api';

import './styles.css';

const TeacherForm: React.FC = () => {
  const [name, setName] = useState('');
  const [avatar, setAvatar] = useState('');
  const [whatsapp, setWhatsapp] = useState('');
  const [bio, setBio] = useState('');

  const [subject, setSubject] = useState('');
  const [cost, setCost] = useState('');

  const [scheduleItems, setScheduleItems] = useState([
    { week_day: 0, from: '', to: ''}
  ])

  const history = useHistory();

  function setScheduleItemValue(position:number, field: string, value: string){
    const updatedScheduleItems = scheduleItems.map((item, index) => {
      if(index === position){
        return {...item, [field]:value}
      }
      return item;
    });

    setScheduleItems(updatedScheduleItems);
  }

  function handleCreateClass(event: FormEvent){
    event.preventDefault();

    api.post('/classes', {
      name,
      avatar,
      whatsapp,
      bio,
      subject,
      cost: Number(cost),
      schedule: scheduleItems
    }).then(()=> {
      alert('Cadastro realizado com sucesso!');
      history.push('/');
    }).catch(() => {
      alert('Erro no cadastro');
    })
  }

  function addNewScheduleItem(){
    setScheduleItems([...scheduleItems, { week_day: 0, from: '', to: ''}])
  }

  return (
    <div id="page-teacher-form" className="container">
      <PageHeader 
        description="O primeiro passo é preencher esse formulário de inscrição."
        title="Que incrível que você quer dar aulas."/>
        <main>
          <form onSubmit={handleCreateClass}>
            <fieldset>
              <legend>Seus dados</legend>

              <Input name="name" 
                label="Nome completo" 
                value={name} 
                onChange={(e)=> setName(e.target.value)}
              />

              <Input name="avatar" label="Avatar"
                value={avatar} 
                onChange={(e)=> setAvatar(e.target.value)}
              />

              <Input name="whatsapp" label="Whatsapp"
                value={whatsapp} 
                onChange={(e)=> setWhatsapp(e.target.value)}
              />

              <TextArea name="bio" label="Biografia"
                value={bio} 
                onChange={(e)=> setBio(e.target.value)}
              />
            </fieldset>

            <fieldset>
              <legend>Sobre a aula</legend>
              <Select 
                name="subject" 
                label="Matéria"
                value={subject}
                onChange={(e)=> setSubject(e.target.value)}
                options={[
                  {value: 'Artes', label: 'Artes'},
                  {value: 'Biologia', label: 'Biologia'},
                  {value: 'Educação Física', label: 'Educação Física'},
                  {value: 'Português', label: 'Português'},
                  {value: 'Química', label: 'Química'},
                ]}
              />
              <Input name="cost" 
                label="Custo da sua hora por aula"
                value={cost}
                onChange={(e)=> setCost(e.target.value)}
              />
            </fieldset>

            <fieldset>
              <legend>
                disponíveis
                <button type="button" onClick={addNewScheduleItem}>+ Novo horário</button>
              </legend>

              {scheduleItems.map((item, index) => (
                <div key={item.week_day} className="schedule-item">
                  <Select 
                    name="week_day" 
                    label="Dia da semana"
                    value={item.week_day}
                    onChange={e => setScheduleItemValue(index, 'week_day', e.target.value)}
                    options={[
                      {value: '0', label: 'Domingo'},
                      {value: '1', label: 'Segunda-feira'},
                      {value: '2', label: 'Terça-feira'},
                      {value: '3', label: 'Quarta-feira'},
                      {value: '4', label: 'Quinta-feira'},
                      {value: '5', label: 'Sexta-feira'},
                      {value: '6', label: 'Sabádo'},
                    ]}
                  />
                  <Input name="from" 
                    label="Das" 
                    type="time"
                    value={item.from}
                    onChange={e => setScheduleItemValue(index, 'from', e.target.value)} 
                  />
                  <Input name="to" 
                    label="Até" 
                    type="time"
                    value={item.to}
                    onChange={e => setScheduleItemValue(index, 'to', e.target.value)} 
                  />
                </div>
              ))}
            </fieldset>

            <footer>
              <p>
                <img src={warningIcon} alt="Aviso importante"/>
                Importante!<br/>
                Preencha todos os dados
              </p>
              <button type="submit">Salvar cadastro</button>
            </footer>
          </form>
        </main>
    </div>
  );
}

export default TeacherForm;