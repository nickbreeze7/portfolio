import React  from 'react';
import {  Text } from 'react-native';
import  styles  from './styles';


const Title = ({ text, style }) => {
    //console.log('props :>>>>>>>>>> ', props);
/*
    const [stateText, setText] = useState('');
    console.log('UPDATE');
    const onTextPress = () => {
        setText('Updated state');
    };
*/
    return (
            <Text  style={[styles.title, style]}> { text }  </Text>
    );
};

Title.defaultProps = {
    text: 'Default Text'
};

export default React.memo(Title);
